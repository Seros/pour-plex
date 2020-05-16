// These are needed - bottle-react parses this file to build a javascript dependency tree.
// require react.development.js
// require react-dom.development.js
// require material-ui.development.js

const {
    colors,
    CssBaseline,
    ThemeProvider,
    Typography,
    Container,
    makeStyles,
    createMuiTheme,
    Box,
    SvgIcon,
    Link,
    Button
} = MaterialUI;

class HelloWorld extends React.Component {
    render() {
        return (
            <div>
                <h1>Hello {this.props.name}!</h1>
                <div>
                    Thanks for trying <a href="https://github.com/keredson/bottle-react"
                                         target='_blank'>bottle-react</a>!
                </div>
                <Button variant="contained" color="primary">
                    Hello World
                </Button>
            </div>
        );
    }
}

bottlereact._register('HelloWorld', HelloWorld)