import type { Album, ICloudPhotoDownload } from "~/types";
import { Image } from "@mantine/core";

import ICloudPhotoDownloadButton from "~/components/ICloudPhotoDownloadButton";
import AppLayout from "~/components/AppLayout";

export interface HomePageProps extends SharedPageProps {
  album: Album;
  downloads: ICloudPhotoDownload[];
}

const AlbumPage: PageComponent<HomePageProps> = ({ album, downloads }) => {
  // == Download webpage URLs
  useSubscription<{
    download: ICloudPhotoDownload;
  }>("AlbumDownloadsChannel", {
    descriptor: "subscribe to album downloads",
    params: {
      album_id: album.id,
    },
    onData: () => {
      router.reload({ only: ["downloads"] });
    },
  });

  return (
    <Stack>
      <Title size="h2">{album.title}</Title>
      {!isEmpty(downloads) && (
        <Box>
          <Title order={2} size="h5">
            iCloud image download links:
          </Title>
          <List>
            {downloads.map(download => (
              <List.Item key={download.id}>
                <Anchor href={download.webpageUrl}>{download.id}</Anchor>
                {download.image ? (
                  <Image
                    srcSet={download.image.srcSet}
                    alt={download.image.filename}
                    w={140}
                  />
                ) : (
                  <>
                    {" "}
                    (
                    <ICloudPhotoDownloadButton
                      variant="default"
                      {...{ download }}
                    />
                    )
                  </>
                )}
              </List.Item>
            ))}
          </List>
        </Box>
      )}
    </Stack>
  );
};

AlbumPage.layout = buildLayout<HomePageProps>((page, { album }) => (
  <>
    <AppLayout title={album.title} withContainer containerSize="xs" withGutter>
      {page}
    </AppLayout>
  </>
));

export default AlbumPage;
