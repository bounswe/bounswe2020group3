import React, { useState } from "react";
import DateFnsUtils from '@date-io/date-fns'
import { KeyboardDatePicker, MuiPickersUtilsProvider /*DatePicker*/ } from "@material-ui/pickers";

function DateComponent(props) {
    // initialDate = undefined
    // props.dateValue !== undefined ? initialDate = props.dateValue : new Date(); 
    const [selectedDate, handleDateChange] = useState(props.dateValue);
    // var now = new Date();
    // var currentDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();

    const handleDate = (date) => {
        let month = (parseInt(date.getMonth())+1).toString()
        if(month.length === 1){ month = "0"+month; }
        let dateString = date.getFullYear() + "-" + month + "-" + date.getDate();
        handleDateChange(date);
        props.handleDateChange(dateString);        
    }
    let past = props.past
    return (
            <MuiPickersUtilsProvider utils={DateFnsUtils}>
                <KeyboardDatePicker
                    style={props.style}
                    value={selectedDate}
                    // placeholder={props.dateValue ? props.dateValue : currentDate}
                    //for accessing the data
                    onChange={date => handleDate(date)}
                    minDate={past ? new Date("1900", "01") :  new Date()}
                    format="dd/MM/yyyy"
                    variant="dialog"
                    helperText={props.helperText}
                />
            </MuiPickersUtilsProvider>
    );
}

export default DateComponent;