import { createMuiTheme } from '@material-ui/core/styles';

export const theme = createMuiTheme({
  palette: {
    primary: {
      light: "#5e92f3", // will be calculated from palette.primary.main,
      main: '#1565c0',
      dark: "#003c8f",// will be calculated from palette.primary.main,
      text: "ffffff",
      contrastText: "white" //will be calculated to contrast with palette.primary.main
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
// export const theme = createMuiTheme({
//   palette: {
//     primary: {
//       // light: will be calculated from palette.primary.main,
//       main: '#1565c0',
//       // dark: will be calculated from palette.primary.main,
//       // contrastText: will be calculated to contrast with palette.primary.main
//     },
//     secondary: {
//       light: '#c3fdff',
//       main: '#90caf9',
//       // dark: will be calculated from palette.secondary.main,
//     },
//     // error: will use the default color
//   },
// });