import Foundation

public class DateUtil {

    public class func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }

    public class func stringify(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: date)
    }

    public class func stringify(_ dates: [Date], format: String = "yyyy-MM-dd") -> [String] {
        return dates.map { stringify($0, format: format) }
    }

}