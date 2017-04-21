
import Foundation

class MovieModel: NSObject {
    
    var movieName: String?
    var posterImagePath: String?
    
    init?(dictionary: NSDictionary?) {
        super.init()
        // This prevents cases in which the array exists but with an garbage value
        guard let dictionary = dictionary else {
            return nil
        }
        self.parseDictionary(dictionary: dictionary)
    }
    
    func parseDictionary(dictionary: NSDictionary) {
        
        if let movieName = dictionary["name"] as? String {
            self.movieName = movieName
        }
        if let posterPath = dictionary["poster-image"] as? String {
          self.posterImagePath = posterPath
        }
        
    }
}
