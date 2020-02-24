//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

class UIHostingTableViewCell<Content: View> : UITableViewCell {
    var contentHostingController: UIHostingController<Content>?
    
    var content: Content? {
        get {
            contentHostingController?.rootView
        } set {
            guard let content = newValue else {
                return
            }
            
            if let contentHostingController = contentHostingController {
                contentHostingController.rootView = content
            } else {
                contentHostingController = UIHostingController(rootView: content)
                
                let view = contentHostingController!.view!
                let margins = contentView.layoutMarginsGuide
                
                view.translatesAutoresizingMaskIntoConstraints = false
                
                contentView.addSubview(view)
                
                NSLayoutConstraint.activate([
                    view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                    view.topAnchor.constraint(equalTo: margins.topAnchor),
                    view.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                    view.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
                ])
            }
        }
    }
}

extension String {
    static let hostingTableViewCellIdentifier = "UIHostingTableViewCell"
}

#endif