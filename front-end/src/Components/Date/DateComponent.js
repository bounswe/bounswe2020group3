import React, { Fragment, useState } from "react";
import DateFnsUtils from '@date-io/date-fns'
import { KeyboardDatePicker, MuiPickersUtilsProvider, DatePicker } from "@material-ui/pickers";

function DateComponent(props) {
    const [selectedDate, handleDateChange] = useState(new Date());
    var now = new Date();
    var currentDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();

    const handleDate = (date) => {
        handleDateChange(date);
        props.handleDateChange(date);
    }

    return (
        
            <MuiPickersUtilsProvider utils={DateFnsUtils}>
                <KeyboardDatePicker
                    style={props.style}
                    clearable
                    value={selectedDate}
                    placeholder={currentDate}
                    //for accessing the data
                    onChange={date => handleDate(date)}
                    minDate={new Date()}
                    format="dd/MM/yyyy"
                    variant="dialog"
                    helperText={props.helperText}
                />
            </MuiPickersUtilsProvider>
        
    );
}

export default DateComponent;