import { MantineProvider } from "@mantine/core";
import { THEME } from "~/helpers/mantine";

export interface EmailMantineProviderProps extends PropsWithChildren {}

const EmailMantineProvider: FC<EmailMantineProviderProps> = ({ children }) => (
  <MantineProvider theme={THEME} forceColorScheme="dark">
    {children}
  </MantineProvider>
);

export default EmailMantineProvider;
