//
//  String+BFKit.swift
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

/// This extesion adds some useful functions to String
public extension String
{
    // MARK: - Variables -
    
    /// Return the float value
    public var floatValue: Float
    {
        return (self as NSString).floatValue
    }
    
    // MARK: - Instance functions -
    
    /**
    Returns the lenght of the string
    
    :returns: Returns the lenght of the string
    */
    public var length: Int
    {
        return count(self)
    }
    
    /**
    Get the character at a given index
    
    :param: index The index
    
    :returns: Returns the character at a given index
    */
    public func characterAtIndex(index: Int) -> Character
    {
        return self[advance(self.startIndex, index)]
    }
    
    /**
    It's like substringFromIndex(index: String.Index), but it requires an Int as index
    
    :param: index The index
    
    :returns: Returns the substring from index
    */
    public func substringFromIndex(index: Int) -> String
    {
        return self[advance(self.startIndex, index)...advance(self.startIndex, self.length-1)]
    }
    
    /**
    It's like substringToIndex(index: String.Index), but it requires an Int as index
    
    :param: index The index
    
    :returns: Returns the substring to index
    */
    public func substringToIndex(index: Int) -> String
    {
        return self[advance(self.startIndex, 0)...advance(self.startIndex, index-1)]
    }
    
    /**
    Creates a substring with a given range
    
    :param: range The range
    
    :returns: Returns the string between the range
    */
    public func substringWithRange(range: Range<Int>) -> String
    {
        let start = advance(self.startIndex, range.startIndex)
        let end = advance(self.startIndex, range.endIndex)
        
        return self.substringWithRange(start..<end)
    }
    
    /**
    Creates a substring from the given character
    
    :param: character The character
    
    :returns: Returns the substring from character
    */
    public func substringFromCharacter(character: Character) -> String?
    {
        if let index: Int = self.indexOfCharacter(character)
        {
            return substringFromIndex(index)
        }
        return nil
    }
    
    /**
    Creates a substring to the given character
    
    :param: character The character
    
    :returns: Returns the substring to character
    */
    public func substringToCharacter(character: Character) -> String?
    {
        if let index: Int = self.indexOfCharacter(character)
        {
            return substringToIndex(index)
        }
        return nil
    }
    
    /**
    Returns the index of the given character
    
    :param: char The character to search
    
    :returns: Returns the index of the given character, nil if not found
    */
    public func indexOfCharacter(character: Character) -> Int?
    {
        if let index = find(self, character)
        {
            return distance(self.startIndex, index)
        }
        return nil
    }
    
    /**
    Search in a given string a substring from the start char to the end char (excluded form final string).
    Example: "This is a test" with start char 'h' and end char 't' will return "is is a "
    
    :param: charStart The start char
    :param: charEnd   The end char
    
    :returns: Returns the substring
    */
    public func searchCharStart(charStart: Character, charEnd: Character) -> String
    {
        return String.searchInString(self, charStart: charStart, charEnd: charEnd)
    }
    
    /**
    Check if self has the given substring in case-sensitive
    
    :param: string        The substring to be searched
    :param: caseSensitive If the search has to be case-sensitive or not
    
    :returns: Returns true if founded, false if not
    */
    public func hasString(string: String, caseSensitive: Bool = true) -> Bool
    {
        if caseSensitive
        {
            return self.rangeOfString(string) != nil
        }
        else
        {
            return self.lowercaseString.rangeOfString(string.lowercaseString) != nil
        }
    }
    
    /**
    Check if self is an email
    
    :returns: Returns true if it's an email, false if not
    */
    public func isEmail() -> Bool
    {
        return String.isEmail(self)
    }
    
    /**
    Encode the given string to Base64
    
    :returns: Returns the encoded string
    */
    public func encodeToBase64() -> String
    {
        return String.encodeToBase64(self)
    }
    
    /**
    Decode the given Base64 to string
    
    :returns: Returns the decoded string
    */
    public func decodeBase64() -> String
    {
        return String.decodeBase64(self)
    }
    
    /**
    Conver self to a capitalized string.
    Example: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test"
    
    :returns: Returns the capitalized sentence string
    */
    public func sentenceCapitalizedString() -> String
    {
        if self.length == 0
        {
            return ""
        }
        let uppercase: String = self.substringToIndex(1).uppercaseString
        let lowercase: String = self.substringFromIndex(1).lowercaseString
        
        return uppercase.stringByAppendingString(lowercaseString)
    }
    
    /**
    Returns a human legible string from a timestamp
    
    :returns: Returns a human legible string from a timestamp
    */
    public func dateFromTimestamp() -> String
    {
        let year: String = self.substringToIndex(4)
        var month: String = self.substringFromIndex(5)
        month = month.substringToIndex(4)
        var day: String = self.substringFromIndex(8)
        day = day.substringToIndex(2)
        var hours: String = self.substringFromIndex(11)
        hours = hours.substringToIndex(2)
        var minutes: String = self.substringFromIndex(14)
        minutes = minutes.substringToIndex(2)
        
        return "\(day)/\(month)/\(year) \(hours):\(minutes)"
    }
    
    /**
    Returns a new string containing matching regular expressions replaced with the template string
    
    :param: regexString The regex string
    :param: replacement The replacement string
    
    :returns: Returns a new string containing matching regular expressions replaced with the template string
    */
    public func stringByReplacingWithRegex(regexString: NSString, withString replacement: NSString) -> NSString
    {
        let regex: NSRegularExpression = NSRegularExpression(pattern: regexString as String, options: .CaseInsensitive, error: nil)!
        return regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range:NSMakeRange(0, self.length), withTemplate: "")
    }
    
    /**
    Encode self to an encoded url string
    
    :returns: Returns the encoded NSString
    */
    public func URLEncode() -> String
    {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    // TODO: Missing hash functions
    
    /**
    Create a MD5 string from self
    
    :returns: Returns the MD5 NSString from self
    */
    private func MD5() -> String
    {
        return ""
    }
    
    /**
    Create a SHA1 string from self
    
    :returns: Returns the SHA1 NSString from self
    */
    private func SHA1() -> String
    {
        return ""
    }
    
    /**
    Create a SHA256 string from self
    
    :returns: Returns the SHA256 NSString from self
    */
    private func SHA256() -> String
    {
        return ""
    }
    
    /**
    Create a SHA512 string from self
    
    :returns: Returns the SHA512 NSString from self
    */
    private func SHA512() -> String
    {
        return ""
    }
    
    // MARK: - Subscript functions -
    
    /**
    Returns the character at the given index
    
    :param: index The index
    
    :returns: Returns the character at the given index
    */
    public subscript(index: Int) -> Character
    {
        return self[advance(self.startIndex, index)]
    }
    
    /**
    Returns the character at the given index as String
    
    :param: index The index
    
    :returns: Returns the character at the given index as String
    */
    public subscript(index: Int) -> String
    {
            return String(self[index] as Character)
    }
    
    /**
    Returns the string from a given range
    
    :param: range The range
    
    :returns: Returns the string from a given range
    */
    public subscript(range: Range<Int>) -> String
    {
        let start = advance(self.startIndex, range.startIndex)
        let end = advance(self.startIndex, range.endIndex)
        
        return self[start..<end]
    }
    
    // MARK: - Class functions -
    
    /**
    Search in a given string a substring from the start char to the end char (excluded form final string).
    Example: "This is a test" with start char 'h' and end char 't' will return "is is a "
    
    :param: string    The string to search in
    :param: charStart The start char
    :param: charEnd   The end char
    
    :returns: Returns the substring
    */
    public static func searchInString(string: String, charStart: Character, charEnd: Character) -> String
    {
        var start = 0, stop = 0
        
        for var i = 0; i < string.length; i++
        {
            if string.characterAtIndex(i) == charStart
            {
                start = i+1
                i += 1
            }
            if string.characterAtIndex(i) == charEnd
            {
                stop = i
                break
            }
        }
        
        stop -= start
        
        return string.substringFromIndex(start).substringToIndex(stop)
    }
    
    /**
    Check if the given string is an email
    
    :param: email The string to be checked
    
    :returns: Returns true if it's an email, false if not
    */
    public static func isEmail(email: String) -> Bool
    {
        let emailRegEx: String = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return regExPredicate.evaluateWithObject(email.lowercaseString)
    }
    
    /**
    Convert a string to UTF8
    
    :param: string String to be converted
    
    :returns: Returns the converted string
    */
    public static func convertToUTF8Entities(string: String) -> String
    {
        return string
            .stringByReplacingOccurrencesOfString("%27", withString: "'")
            .stringByReplacingOccurrencesOfString("%e2%80%99".capitalizedString, withString: "’")
            .stringByReplacingOccurrencesOfString("%2d".capitalizedString, withString: "-")
            .stringByReplacingOccurrencesOfString("%c2%ab".capitalizedString, withString: "«")
            .stringByReplacingOccurrencesOfString("%c2%bb".capitalizedString, withString: "»")
            .stringByReplacingOccurrencesOfString("%c3%80".capitalizedString, withString: "À")
            .stringByReplacingOccurrencesOfString("%c3%82".capitalizedString, withString: "Â")
            .stringByReplacingOccurrencesOfString("%c3%84".capitalizedString, withString: "Ä")
            .stringByReplacingOccurrencesOfString("%c3%86".capitalizedString, withString: "Æ")
            .stringByReplacingOccurrencesOfString("%c3%87".capitalizedString, withString: "Ç")
            .stringByReplacingOccurrencesOfString("%c3%88".capitalizedString, withString: "È")
            .stringByReplacingOccurrencesOfString("%c3%89".capitalizedString, withString: "É")
            .stringByReplacingOccurrencesOfString("%c3%8a".capitalizedString, withString: "Ê")
            .stringByReplacingOccurrencesOfString("%c3%8b".capitalizedString, withString: "Ë")
            .stringByReplacingOccurrencesOfString("%c3%8f".capitalizedString, withString: "Ï")
            .stringByReplacingOccurrencesOfString("%c3%91".capitalizedString, withString: "Ñ")
            .stringByReplacingOccurrencesOfString("%c3%94".capitalizedString, withString: "Ô")
            .stringByReplacingOccurrencesOfString("%c3%96".capitalizedString, withString: "Ö")
            .stringByReplacingOccurrencesOfString("%c3%9b".capitalizedString, withString: "Û")
            .stringByReplacingOccurrencesOfString("%c3%9c".capitalizedString, withString: "Ü")
            .stringByReplacingOccurrencesOfString("%c3%a0".capitalizedString, withString: "à")
            .stringByReplacingOccurrencesOfString("%c3%a2".capitalizedString, withString: "â")
            .stringByReplacingOccurrencesOfString("%c3%a4".capitalizedString, withString: "ä")
            .stringByReplacingOccurrencesOfString("%c3%a6".capitalizedString, withString: "æ")
            .stringByReplacingOccurrencesOfString("%c3%a7".capitalizedString, withString: "ç")
            .stringByReplacingOccurrencesOfString("%c3%a8".capitalizedString, withString: "è")
            .stringByReplacingOccurrencesOfString("%c3%a9".capitalizedString, withString: "é")
            .stringByReplacingOccurrencesOfString("%c3%af".capitalizedString, withString: "ï")
            .stringByReplacingOccurrencesOfString("%c3%b4".capitalizedString, withString: "ô")
            .stringByReplacingOccurrencesOfString("%c3%b6".capitalizedString, withString: "ö")
            .stringByReplacingOccurrencesOfString("%c3%bb".capitalizedString, withString: "û")
            .stringByReplacingOccurrencesOfString("%c3%bc".capitalizedString, withString: "ü")
            .stringByReplacingOccurrencesOfString("%c3%bf".capitalizedString, withString: "ÿ")
            .stringByReplacingOccurrencesOfString("%20", withString: " ")
    }
    
    /**
    Encode the given string to Base64
    
    :param: string String to encode
    
    :returns: Returns the encoded string
    */
    public static func encodeToBase64(string: String) -> String
    {
        let data: NSData = string.dataUsingEncoding(NSUTF8StringEncoding)!
        return data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
    
    /**
    Decode the given Base64 to string
    
    :param: string String to decode
    
    :returns: Returns the decoded string
    */
    public static func decodeBase64(string: String) -> String
    {
        let data: NSData = NSData(base64EncodedString: string as String, options: NSDataBase64DecodingOptions(rawValue: 0))!
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }
}
