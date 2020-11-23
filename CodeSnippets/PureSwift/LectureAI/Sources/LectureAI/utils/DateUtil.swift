import Foundation

open class DateUtil {

    public init() {

    }

    public func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }

    public func stringify(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: date)
    }

    public func stringify(_ dates: [Date], format: String = "yyyy-MM-dd") -> [String] {
        return dates.map { stringify($0, format: format) }
    }

    public func getWeekdayNumberOfGermanString(germanString: String) -> Int {
        switch germanString {
        case "Sonntag":
            return 1
        case "Montag":
            return 2
        case "Dienstag":
            return 3
        case "Mittwoch":
            return 4
        case "Donnerstag":
            return 5
        case "Freitag":
            return 6
        case "Samstag":
            return 7
        default:
            return -1
        }
    }

    //returns date with wanted year (possible YearModifiers: .previous, .current, .next)
    public func getDateInWantedYear(day: String, month: String, yearModifier: YearModifier) -> Date {
        let year = Int(getCurrentYear() + yearModifier.rawValue) //add value of enums to year from date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: "\(day).\(month).\(year)")!
    }

    public func getWeekDayIdOfDate(date: Date) -> Int {
        return Int(Calendar.current.component(.weekday, from: date))
    }

    open func getCurrentMonth() -> Int {
        return Int(Calendar.current.component(.month, from: Date()))
    }

    open func getCurrentYear() -> Int {
        return Int(Calendar.current.component(.year, from: Date()))
    }

}