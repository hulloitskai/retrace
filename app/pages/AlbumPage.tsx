import type { Album } from "~/types";

import AppLayout from "~/components/AppLayout";

export interface HomePageProps extends SharedPageProps {
  album: Album;
  downloadWebpageUrls: string[];
}

const AlbumPage: PageComponent<HomePageProps> = ({
  album,
  downloadWebpageUrls: initialDownloadWebpageUrls,
}) => {
  // == Download webpage URLs
  const [downloadWebpageUrls, setDownloadWebpageUrls] = useState(
    initialDownloadWebpageUrls,
  );
  useSubscription<{
    downloadWebpageUrl: string;
  }>("AlbumDownloadCreatedChannel", {
    descriptor: "subscribe to album downloads",
    params: {
      album_id: album.id,
    },
    onData: ({ downloadWebpageUrl }) => {
      setDownloadWebpageUrls(prevUrls => [...prevUrls, downloadWebpageUrl]);
    },
  });

  return (
    <Stack>
      <Title size="h2">{album.title}</Title>
      {!isEmpty(downloadWebpageUrls) && (
        <Box>
          <Title order={2} size="h5">
            iCloud image download links:
          </Title>
          {downloadWebpageUrls.map(url => (
            <Anchor
              key={url}
              href={url}
              truncate
              style={{ display: "block", minWidth: 0 }}
            >
              {url}
            </Anchor>
          ))}
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
