import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';

extension DateTimeExtension on DateTime {
    /// Get the floor of a date.
    /// 
    /// The floor is a new [DateTime] object with only the year, month, and day copied from the original source.
    DateTime get lunaFloor => DateTime(this.year, this.month, this.day);

    /// Returns a string representation of the "age" of the [DateTime] object.
    /// 
    /// Compares to [DateTime.now().toLocal()] to calculate the age.
    String get lunaAge {
        if(this == null) return 'Unknown';
        Duration diff = DateTime.now().toLocal().difference(this);
        if(diff.inDays >= 1) return '${diff.inDays} ${diff.inDays == 1 ? 'Day' : 'Days'} Ago';
        if(diff.inHours >= 1) return '${diff.inHours} ${diff.inHours == 1 ? 'Hour' : 'Hours'} Ago';
        if(diff.inMinutes >= 1) return '${diff.inMinutes} ${diff.inMinutes == 1 ? 'Minute' : 'Minutes'} Ago';
        return '${diff.inSeconds} ${diff.inSeconds == 1 ? 'Second' : 'Seconds'} Ago';
    }

    /// Returns a string representation of how far in the future the day is.
    /// 
    /// Compares to [DateTime.now().toLocal()] to calculate the upcoming time.
    String get lunaUpcomingDays {
        if(this == null) return 'Unknown';
        Duration diff = this.difference(DateTime.now().toLocal());
        if(diff.inDays == 0) return 'Today';
        return 'In ${diff.inDays} ${diff.inDays == 1 ? "Day" : "Days"}';
    }

    /// Returns just the time as a string.
    /// 
    /// 3 PM will return either 15:00 (24 hour style) or 3:00 PM depending on the configured database option.
    String get lunaTime => LunaDatabaseValue.USE_24_HOUR_TIME.data ? DateFormat.Hm().format(this) : DateFormat.jm().format(this);

    /// Returns just the date as a string.
    /// 
    /// Formatted as YYYY-MM-DD
    String get lunaDate => '${this.year.toString().padLeft(4, '0')}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}';


}
