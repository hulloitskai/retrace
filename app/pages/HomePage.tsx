import type { Album } from "~/types";
import ShareIcon from "~icons/lucide/share";

import { Text } from "@mantine/core";

import AppLayout from "~/components/AppLayout";

export interface HomePageProps extends SharedPageProps {
  announcement: string | null;
}

const HomePage: PageComponent<HomePageProps> = ({ announcement }) => {
  // == Announcement
  useEffect(() => {
    if (announcement) {
      showNotice({ message: announcement });
    }
  }, [announcement]);

  // == Create album
  const initialValues = {
    title: "",
    initialImportAttributes: { webpageUrl: "" },
  };
  const { values, getInputProps, submit, processing } = useFetchForm<
    { album: Album },
    typeof initialValues
  >({
    action: routes.albums.create,
    method: "post",
    descriptor: "create map",
    initialValues,
    transformValues: values => ({ album: deepUnderscoreKeys(values) }),
    onSuccess: ({ album }) => {
      router.visit(routes.albums.show.path({ id: album.slug }));
    },
  });

  return (
    <Stack>
      <Title size="h1">Visualize your iPhone photos on an animated map.</Title>
      <Text lh="xs">
        On your iPhone, open a photo album and click the{" "}
        <Badge
          leftSection={<ShareIcon />}
          mx={4}
          pos="relative"
          top={2}
          styles={{ label: { textTransform: "none" } }}
        >
          share
        </Badge>{" "}
        icon. Copy the link and paste it below.
      </Text>
      <Box component="form" onSubmit={submit}>
        <Stack>
          <Card withBorder>
            <Stack gap={6}>
              <TextInput
                {...getInputProps("initialImportAttributes.webpageUrl")}
                label="Album link"
                placeholder="https://share.icloud.com/photos/01aB2cDiJArw2K4g74UF-k_2x"
                required
                withAsterisk={false}
              />
              <TextInput
                {...getInputProps("title")}
                label="Album name"
                placeholder="My trip to Paris"
                required
                withAsterisk={false}
              />
            </Stack>
          </Card>
          <Button
            type="submit"
            size="lg"
            color="white"
            disabled={
              !values.title || !values.initialImportAttributes.webpageUrl
            }
            loading={processing}
          >
            Generate my map :)
          </Button>
        </Stack>
      </Box>
    </Stack>
  );
};

HomePage.layout = buildLayout<HomePageProps>(page => (
  <>
    <AppLayout withContainer containerSize="xs" withGutter>
      {page}
    </AppLayout>
  </>
));

export default HomePage;
