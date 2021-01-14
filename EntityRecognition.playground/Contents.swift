import NaturalLanguage
import Foundation
import CoreML

var str = "Hello, playground"

extension String {
    func printNamedEntities() {
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        
        tagger.string = self
        
        let range = NSRange(location: 0, length: self.utf16.count)
        
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) {
            (tag, tokenRange, stop) in
            
            if let tag = tag, tags.contains(tag) {
                let name = (self as NSString).substring(with: tokenRange)
                
                print("\(name) is a \(tag.rawValue)")
            }
        }
    }
}

let sentence = "Marina, Jon, and Tim write books for O'Reilly Media and live in Tasmania, Australia."

sentence.printNamedEntities()


