//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by Jayyoung Yang on 09/11/2018.
//  Copyright © 2018 Jayyoung Yang. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    var page = 1
//    // 튜플 아이템으로 구성된 데이터 세트
//    var dataset = [
//        ("다크 나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95, "darknight.jpg"),
//        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
//        ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
//    ]
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
//        for (title, desc, opendate, rating, thumbnail) in self.dataset {
//            let mvo = MovieVO()
//            mvo.title = title
//            mvo.description = desc
//            mvo.opendate = opendate
//            mvo.rating = rating
//            mvo.thumbnail = thumbnail
//
//            datalist.append(mvo)
//        }
        return datalist
    }()

    @IBOutlet var moreBtn: UIButton!
    
    @IBAction func more(_ sender: Any) {
        // 0. 현재 페이지 값에 1을 추가한다.
        self.page += 1
        
//        // 1. 호핀 API 호출을 위한 URI를 생성
//        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
//        let apiURI: URL! = URL(string: url)
//
//        // REST API를 호출
//        let apidata = try! Data(contentsOf: apiURI)
//
//        // 3. 데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
//        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다."
//        NSLog("API Result = \(log)")
//
//        // 4. JSON 객체를 파싱하여 NSDictionary 객체로 변환
//        do {
//            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
//
//            // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
//            let hoppin = apiDictionary["hoppin"] as! NSDictionary
//            let movies = hoppin["movies"] as! NSDictionary
//            let movie = movies["movie"] as! NSArray
//
//            // 6. Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
//            for row in movie {
//                // 순회 상수를 NSDictionary 타입으로 캐스팅
//                let r = row as! NSDictionary
//
//                // 테이블 뷰 리스트를 구성할 데이터 형식
//                let mvo = MovieVO()
//
//                mvo.title = r["title"] as? String
//                mvo.description = r["genreNames"] as? String
//                mvo.thumbnail = r["thumbnailImage"] as? String
//                mvo.detail = r["linkUrl"] as? String
//                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
//
//                // list 배열에 추가
//                self.list.append(mvo)
//
//                // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
//                self.tableView.reloadData()
//            }
//        } catch {}
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
        
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
//        // 첫번쨰 행
//        var mvo = MovieVO()
//        mvo.title = "다크나이트"
//        mvo.description = "영웅물에 철학에 음악까지 더해져 예술이 되다."
//        mvo.opendate = "2008-09-04"
//        mvo.rating = 8.95
//        // 배열에 추가
//        self.list.append(mvo)
//
//        // 두번째 행
//        mvo = MovieVO()
//        mvo.title = "호우시절"
//        mvo.description = "때를 알고 내리는 좋은 비"
//        mvo.opendate = "2009-10-08"
//        mvo.rating = 7.31
//        // 배열에 추가
//        self.list.append(mvo)
//
//        // 세번째 행
//        mvo = MovieVO()
//        mvo.title = "말할 수 없는 비밀"
//        mvo.description = "여기서 너까지 다섯 걸음"
//        mvo.opendate = "2015-05-07"
//        mvo.rating = 9.19
//        // 배열에 추가
//        self.list.append(mvo)
//        // 1. 호핀 API 호출을 위한 URI를 생성
//        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
//        let apiURI: URL! = URL(string: url)
//
//        // 2. EST API를 호출
//        let apidata = try! Data(contentsOf: apiURI)
//
//        // 3. 데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
//        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
//        NSLog("API Result = \(log)")
//
//        // 4. JSON 객체를 파싱하여 NSDictionary 객체로 받음
//        do {
//            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
//
//            // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
//            let hoppin = apiDictionary["hoppin"] as! NSDictionary
//            let movies = hoppin["movies"] as! NSDictionary
//            let movie = movies["movie"] as! NSArray
//
//            // 6. Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
//            for row in movie {
//                // 순회 상수를 NSDictionary 타입으로 캐스팅
//                let r = row as! NSDictionary
//
//                // 테이블 뷰 리스트를 구성할 데이터 형식
//                let mvo = MovieVO()
//
//                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
//                mvo.title           =  r["title"] as? String
//                mvo.description     = r["genreNames"] as? String
//                mvo.thumbnail       = r["thumbnailImage"] as? String
//                mvo.detail          = r["linkUrl"] as? String
//                mvo.rating          = ((r["ratingAverage"] as! NSString).doubleValue)
//
//                // list 배열에 추가
//                self.list.append(mvo)
//            }
//        } catch {}
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
    }
    
    func getThumbnailImage(_ index: Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션: 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData)   // UIImage를 MovieVO 객체에 우선 저장
            
            return mvo.thumbnailImage!  // 저장된 이미지를 반환
        }
    }
    
    // 영화 차트 API를 호출해주는 메소드
    func callMovieAPI() {
        // 1. 호핀 API 호출을 위한 URI를 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        // 2. REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 3. 데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다."
        NSLog("API Result = \(log)")
        
        // 4. JSON 객체를 파싱하여 NSDictionary 객체로 변환
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title       = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail   = r["thumbnailImage"] as? String
                mvo.detail      = r["linkUrl"] as? String
                mvo.rating      = ((r["ratingAverage"] as? NSString)?.doubleValue)
                
                // <- 추가되는 코드 시작
                // 웹상에 있는 이미지를 읽어와 UIImage 객체로 생성
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                // <- 추가되는 코드 끝
                
                // list 배열에 추가
                self.list.append(mvo)
            }
            
            // 7. 전체 데이터 카운트를 얻는다.
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            // 8. totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다.
            if self.list.count >= totalCount {
                self.moreBtn.isHidden = true
            }
        } catch {
            NSLog("Parse Error!!")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
//        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
//
////        // -------> 추가되는 부분 시작
////        // 영화제목이 표시될 레이블을 title 변수로 받음
////        let title = cell.viewWithTag(101) as? UILabel
////        // 영화요약이 표시될 레이블을 desc 변수로 받음
////        let desc = cell.viewWithTag(102) as? UILabel
////        // 영화 개볼일이 표시될 레이블을 opendate 변수로 받음
////        let opendate = cell.viewWithTag(103) as? UILabel
////        // 영화 별점이 표시될 레이블을 rating 변수로 받음
////        let rating = cell.viewWithTag(104) as? UILabel
////        // 데이터 소스에 저장된 값을 각 레이블 변수에 할당
////        title?.text = row.title
////        desc?.text = row.description
////        opendate?.text = row.opendate
////        rating?.text = "\(row.rating!)"
//        // <---------- 추가되는 부분 끝
        // ============= 여기서부터 내용 변경됨 ==================
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
//        cell.thumbnail.image = UIImage(named: row.thumbnail!)
//        // 섬네일 경로를 인자값으로 하는 URL 객체를 생성
//        let url: URL! = URL(string: row.thumbnail!)
//
//        // 이미지를 읽어와 Data 객체에 저장
//        let imageData = try! Data(contentsOf: url)
//
//        // UIImage 객체를 생성하여 아울렛 변수의 image 속성에 대입
//        cell.thumbnail.image = UIImage(data: imageData)
//        cell.thumbnail.image = row.thumbnailImage
        // 수정) 비동기 방식으로 섬네일 이미지를 읽어옴
        DispatchQueue.main.async(execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        
//        cell.textLabel?.text = row.title
//        // 추가사항: 서브타이틀에 데이터 연결
//        cell.detailTextLabel?.text = row.description
        
        return cell
    }
    // 특정 셀이 클릭되었을때 처리해줄 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번쨰 행입니다.")
    }
    
    
}

// MARK: - 화면 전환 시 값을 넘겨주기 위한 세그웨이 관련 처리
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이의 식별자가 "segue_detail"이라면
        if segue.identifier == "segue_detail" {
            // 사용자가 클릭한 행을 찾아낸다.
            let path = self.tableView.indexPath(for: sender as! MovieCell)
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }
}
