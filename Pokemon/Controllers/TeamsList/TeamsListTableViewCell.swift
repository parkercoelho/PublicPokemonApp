//
//  TeamsListTableViewCell.swift
//  Pokemon
//
//  Created by Parker Coelho on 1/17/23.
//

import UIKit

class TeamsListTableViewCell: UITableViewCell {
    
    var teamTitle: String

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    init(teamTitle: String, style:UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.teamTitle = teamTitle
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
