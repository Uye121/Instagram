//
//  PostCell.swift
//  Instagram
//
//  Created by Ulric Ye on 3/13/17.
//  Copyright © 2017 uye. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
