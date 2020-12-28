import { createMuiTheme } from '@material-ui/core/styles';
export const colorCodes = ["#D2B4DE", "#F8C471", "#76D7C4", "#AED6F1", "#DAF7A6", "#FA8072", "#FEC8D8", "#85EE85", "#FDFD96", "#89AED8"]

export const theme = createMuiTheme({
  palette: {
    primary: {
      light: "#5e92f3", // will be calculated from palette.primary.main,
      main: '#1565c0',
      dark: "#003c8f",// will be calculated from palette.primary.main,
      text: "#ffffff",
      contrastText: "#ffffff" //will be calculated to contrast with palette.primary.main
    },
    secondary: {
      light: '#c3fdff',
      main: '#90caf9',
      dark: '#5d99c6',  // will be calculated from palette.secondary.main,
      contrastText: '#000000',
    },
    // Used by `getContrastText()` to maximize the contrast between
    // the background and the text.
    contrastThreshold: 3,
    // Used by the functions below to shift a color's luminance by approximately
    // two indexes within its tonal palette.
    // E.g., shift from Red 500 to Red 300 or Red 700.
    tonalOffset: 0.2,
  },
});