import { useAuth0 } from "@auth0/auth0-react";
import { Grid, Button } from "@material-ui/core";

export default function MyAccount() {
    const {
        loginWithPopup,
        logout,
        isLoading,
        isAuthenticated,
    } = useAuth0();

    const performLogin = async () => {
        await loginWithPopup();
    };

    const isLoggedIn = !isLoading && isAuthenticated;

    return (
        <Grid container justifyContent="center">
            <Grid item>
                <Button
                    disabled={isLoggedIn}
                    color="primary"
                    onClick={performLogin}
                >
                    Login
                </Button>
            </Grid>
            <Grid item>
                <Button
                    disabled={!isLoggedIn}
                    color="secondary"
                    onClick={logout as any}
                >
                    Logout
                </Button>
            </Grid>
        </Grid>
    );
}
