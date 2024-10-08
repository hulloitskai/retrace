import type { AppShellProps, ContainerProps, MantineSize } from "@mantine/core";
import { AppShell, Breadcrumbs, Button } from "@mantine/core";
import MapIcon from "~icons/heroicons/map-20-solid";

import type { AppMetaProps } from "./AppMeta";
import AppMeta from "./AppMeta";

import AppFlash from "./AppFlash";
import PageContainer from "./PageContainer";
import PageLayout from "./PageLayout";

import classes from "./AppLayout.module.css";

export interface AppLayoutProps
  extends AppMetaProps,
    Omit<AppShellProps, "title"> {
  breadcrumbs?: ReadonlyArray<AppBreadcrumb | null | false>;
  withContainer?: boolean;
  containerSize?: MantineSize | (string & {}) | number;
  containerProps?: ContainerProps;
  withGutter?: boolean;
  gutterSize?: MantineSize | (string & {}) | number;
}

export type AppBreadcrumb = {
  title: string;
  href: string;
};

const AppLayout: FC<AppLayoutProps> = ({
  title,
  description,
  imageUrl,
  noIndex,
  breadcrumbs,
  withContainer,
  containerSize,
  containerProps,
  withGutter,
  gutterSize,
  children,
  padding,
  ...otherProps
}) => {
  // == Breadcrumbs
  const filteredBreadcrumbs = useMemo(
    () => (breadcrumbs?.filter(x => !!x) || []) as AppBreadcrumb[],
    [breadcrumbs],
  );

  // == Content
  const content = useMemo(
    () =>
      withContainer ? (
        <PageContainer
          size={containerSize || containerProps?.size}
          {...{ withGutter, gutterSize }}
          {...containerProps}
        >
          {children}
        </PageContainer>
      ) : (
        children
      ),
    [
      withContainer,
      containerSize,
      withGutter,
      gutterSize,
      containerProps,
      children,
    ],
  );

  return (
    <PageLayout>
      <AppMeta {...{ title, description, imageUrl, noIndex }} />
      <AppShell
        header={{ height: 44 }}
        padding={padding ?? (withContainer ? undefined : "md")}
        styles={{
          root: {
            "--app-shell-border-color": "var(--mantine-color-dark-6) ",
          },
          header: {
            padding: 8,
            display: "flex",
            alignItems: "center",
            justifyContent: "space-around",
            columnGap: 6,
          },
          main: {
            flexGrow: 1,
            minHeight: "calc(100dvh - var(--app-shell-footer-height, 0px))",
            paddingBottom: 0,
            display: "flex",
            flexDirection: "column",
            alignItems: "stretch",
          },
        }}
        {...otherProps}
      >
        <AppShell.Header>
          <Button
            component={Link}
            href={routes.home.show.path()}
            leftSection={<MapIcon />}
            variant="subtle"
            color="accent"
            size="compact-md"
            h="unset"
            py={4}
            px={6}
            fw={800}
            fz="md"
            className={classes.logo}
          >
            Moment
          </Button>
        </AppShell.Header>
        <AppShell.Main>
          {!isEmpty(filteredBreadcrumbs) && (
            <Breadcrumbs
              mx={10}
              mt={6}
              classNames={{
                separator: classes.breadcrumbSeparator,
              }}
              styles={{
                root: {
                  flexWrap: "wrap",
                  rowGap: rem(4),
                },
                separator: {
                  marginLeft: 6,
                  marginRight: 6,
                },
              }}
            >
              {filteredBreadcrumbs.map(({ title, href }, index) => (
                <Anchor component={Link} href={href} key={index} size="sm">
                  {title}
                </Anchor>
              ))}
            </Breadcrumbs>
          )}
          {content}
        </AppShell.Main>
      </AppShell>
      <AppFlash />
    </PageLayout>
  );
};

export default AppLayout;
