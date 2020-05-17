//
//  File.swift
//  MovieWorld
//
//  Created by Admin on 15/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(args: CVarArg...) -> String {
        return withVaList(args) {
            NSString(format: self.localized, locale: Locale.current, arguments: $0) as String
        }
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: integerRange.lowerBound)
        let end = index(startIndex, offsetBy: integerRange.upperBound)
        let range = start..<end
        return String(self[range])
    }

    subscript(integerIndex: Int) -> Character {
        let index = self.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }
}

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
    public func stringByAddingPercentEncodingForFormData(plusForSpace: Bool=false) -> String? {
      let unreserved = "*-._"
      let allowed = NSMutableCharacterSet.alphanumeric()
      allowed.addCharacters(in: unreserved)

      if plusForSpace {
        allowed.addCharacters(in: " ")
      }

      var encoded = addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
      if plusForSpace {
        encoded = encoded?.replacingOccurrences(of: "+", with: "%2C")
      }
      return encoded
    }
}
