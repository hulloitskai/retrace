import { /* ColorSchemeScript, */ MantineProvider } from "@mantine/core";
import { THEME } from "~/helpers/mantine";

export interface AppMantineProviderProps extends PropsWithChildren {}

const AppMantineProvider: FC<AppMantineProviderProps> = ({ children }) => (
  <MantineProvider theme={THEME} forceColorScheme="dark">
    {children}
  </MantineProvider>
);

export default AppMantineProvider;
