//
//  ToUserAnimationViewController.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 9/1/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class ToUserAnimationViewController: NSObject {
	override init() {
		
	}
}

extension ToUserAnimationViewController : UIViewControllerAnimatedTransitioning{
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
		return 0.4
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		//this is the animation
		
		if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController,
			toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserDetailViewController {
				//containerView comes with the fromVC's view already installed
				let containerView = transitionContext.containerView()
				
				toVC.view.alpha = 0
				containerView.addSubview(toVC.view)
				
				let indexPath = fromVC.userCollectionView.indexPathsForSelectedItems().first as! NSIndexPath
				let userCell = fromVC.userCollectionView.cellForItemAtIndexPath(indexPath) as! UserCollectionViewCell
				
				let snapShot = userCell.userImageView.snapshotViewAfterScreenUpdates(false)
				
				snapShot.frame = containerView.convertRect(userCell.userImageView.frame, fromCoordinateSpace: userCell.userImageView.superview!)
				
				containerView.addSubview(snapShot)
				userCell.hidden = true
				
				//ensure that my destination image view is in place
				toVC.view.layoutIfNeeded()
				
				toVC.userDetailImageView.hidden = true
				
				let destinationFrame = toVC.userDetailImageView.frame
				
				UIView.animateWithDuration(0.4, animations: { () -> Void in
					snapShot.frame = destinationFrame
					toVC.view.alpha = 1
					}, completion: { (finished) -> Void in
						userCell.hidden = false
						toVC.userDetailImageView.hidden = false
						snapShot.removeFromSuperview()
						if finished {
							transitionContext.completeTransition(finished)
						} else {
							transitionContext.completeTransition(finished)
						}
				})
		}
		
	}
}
