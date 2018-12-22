//
//  MovieCell.swift
//  MyMovieChart
//
//  Created by Jayyoung Yang on 10/11/2018.
//  Copyright © 2018 Jayyoung Yang. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!       // 영화 제목
    @IBOutlet var opendate: UILabel!    // 개봉일
    @IBOutlet var desc: UILabel!        // 영화 설명
    @IBOutlet var rating: UILabel!      // 평점
    @IBOutlet var thumbnail: UIImageView!
    
    
}
