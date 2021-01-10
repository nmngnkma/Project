//
//  String+.swift
//  Spoon Master
//
//  Created by Nam Ngây on 12/24/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    var isValidEmail: Bool {
          NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
      }
}

extension Database {
    var url: URL? {
        let refAsString = "\(FirebaseDatabase.Database.database().reference())"
        return URL(string: refAsString)
    }
}
