using Toybox.ActivityMonitor as Act;
using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;

class SampleView extends Ui.WatchFace {
	
    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var dateInfo = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        var actInfo = Act.getInfo();
        var settings = Sys.getDeviceSettings();
        
        var dayString = Lang.format("$1$ $2$", [dateInfo.day_of_week, dateInfo.day]);
        var timeString = Lang.format("$1$:$2$", [getHour(settings.is24Hour, clockTime), clockTime.min.format("%02d")]);
        
        // Set label to show current time
        var timeLabel = View.findDrawableById("TimeLabel");
        timeLabel.setText(timeString);
        // Set label to show current date
        var dateLabel = View.findDrawableById("DateLabel");
        dateLabel.setText(dayString);
        // Set label to show current steps
        var stepLabel = View.findDrawableById("StepLabel");
        stepLabel.setText(Lang.format("$1$/$2$", [actInfo.steps, actInfo.stepGoal]));
        // Set Actionbar to show current status
        var actionBar = View.findDrawableById("ActionBar");
        actionBar.setStatus(Sys.getSystemStats().battery, settings.notificationCount, settings.alarmCount, settings.phoneConnected, false);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
    //! Gets the current hour
    function getHour(is24Hour, clockTime) {
    	var hour = clockTime.hour;
    	if (!is24Hour) {
    		if (hour > 12) { return hour - 12; }
    		if (hour == 0) { return 12; }
    	}
    	return hour;
    }

}
