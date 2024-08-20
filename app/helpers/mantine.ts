import type { DefaultMantineColor, MantineColorsTuple } from "@mantine/core";
import { DEFAULT_THEME } from "@mantine/core";
import {
  ActionIcon,
  Alert,
  Button,
  Loader,
  Modal,
  Notification,
  TextInput,
  ThemeIcon,
  createTheme,
} from "@mantine/core";

import cx from "clsx";
import classes from "./mantine.module.css";

export type CustomColors = "primary" | "accent" | DefaultMantineColor;

declare module "@mantine/core" {
  export interface MantineThemeColorsOverride {
    colors: Record<CustomColors, MantineColorsTuple>;
  }
}

const stone: MantineColorsTuple = [
  "#fafaf9",
  "#f5f5f4",
  "#e7e5e4",
  "#d6d3d1",
  "#a8a29e",
  "#78716c",
  "#57534e",
  "#44403c",
  "#292524",
  "#1c1917",
  "#0c0a09",
];

export const THEME = createTheme({
  autoContrast: true,
  colors: {
    dark: stone,
    primary: stone,
    // accent: uglyGreen,
    accent: DEFAULT_THEME.colors.lime,
  },
  primaryColor: "primary",
  defaultRadius: 0,
  fontFamily:
    "Manrope, Inter, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, " +
    "Arial, sans-serif",
  fontFamilyMonospace:
    "JetBrains Mono, ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, " +
    "Liberation Mono, Courier New, monospace",
  headings: {
    fontFamily:
      "Manrope, Inter, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, " +
      "Arial, sans-serif",
  },
  focusClassName: cx("mantine-focus-auto", classes.focus),
  components: {
    ActionIcon: ActionIcon.extend({
      defaultProps: {
        variant: "subtle",
      },
    }),
    Alert: Alert.extend({
      styles: {
        title: {
          fontWeight: 800,
        },
      },
    }),
    Button: Button.extend({
      classNames: {
        root: classes.button,
      },
    }),
    Card: Card.extend({
      classNames: {
        root: classes.card,
      },
    }),
    Loader: Loader.extend({
      defaultProps: {
        size: "sm",
        color: "primary.5",
      },
    }),
    Modal: Modal.extend({
      styles: ({ headings: { sizes, ...style } }) => ({
        header: {
          alignItems: "start",
        },
        title: {
          ...sizes.h4,
          ...style,
        },
      }),
    }),
    Notification: Notification.extend({
      styles: {
        description: {
          lineHeight: "var(--mantine-line-height-xs)",
        },
      },
    }),
    TextInput: TextInput.extend({
      defaultProps: {
        variant: "filled",
      },
      classNames: {
        root: classes.input,
      },
    }),
    ThemeIcon: ThemeIcon.extend({
      defaultProps: {
        variant: "default",
      },
    }),
  },
});
