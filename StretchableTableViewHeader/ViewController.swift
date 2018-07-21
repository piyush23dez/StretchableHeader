//
//  ViewController.swift
//  StretchableTableViewHeader
//
//  Created by Apple on 29/08/17.
//  Copyright © 2017 Abhilash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let imageView = UIImageView()
    var container = UIView()
    var subview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0)
        tableView.backgroundColor = UIColor.darkGray
      
        container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300))
        container.backgroundColor = .green
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        imageView.image = UIImage.init(named: "poster")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        container.addSubview(imageView)
        view.addSubview(container)
    }

    override func viewDidLayoutSubviews() {
        subview = UIView(frame:  CGRect(x: imageView.frame.size.width-60-30, y: imageView.frame.size.height-30, width: 60, height: 60))
        subview.backgroundColor = .blue
        subview.layer.cornerRadius = 30
        container.addSubview(subview)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        switch indexPath.row % 2 {
        case 0:
            cell.titleLabel.text = "Lorem Ipsum is simply dummy text ."
            cell.contentView.backgroundColor = UIColor.darkGray
        default:
            cell.contentView.backgroundColor = UIColor.black
            cell.titleLabel.text = "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
            cell.titleLabel.textColor = .white


        }
        return cell
    }
    
    func getHeight(point1: (x1: CGFloat, y1: CGFloat), point2: (x2: CGFloat, y2: CGFloat), offset: CGFloat) -> CGFloat {
        let y = point1.y1 + ( (point2.y2-point1.y1)/(point2.x2-point1.x1) * (offset - point1.x1))
        return y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 600)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        container.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        let buttonheight = getHeight(point1: (x1: 300, y1: 60), point2: (x2: 60, y2: 50), offset: height)
        let h = min(buttonheight, 60)

        subview.frame = CGRect(x: imageView.frame.size.width-h-h/2, y: imageView.frame.size.height-h/2, width: h, height: h)
        subview.layer.cornerRadius = h/2
    }
}
