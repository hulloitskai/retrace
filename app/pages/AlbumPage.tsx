import type { Album, ICloudPhotosImport, Photo } from "~/types";
// import type { Feature, Point } from "geojson";
import { Popup /* Layer, Source */ } from "react-map-gl";
import { Image, Progress, Text } from "@mantine/core";

import AppLayout from "~/components/AppLayout";
import Map from "~/components/Map";

import classes from "./AlbumPage.module.css";

export interface AlbumPageProps extends SharedPageProps {
  album: Album;
  imports: ICloudPhotosImport[];
}

const AlbumPage: PageComponent<AlbumPageProps> = ({ album, imports }) => {
  // == Photos
  const { data: photosData, mutate } = useFetch<{ photos: Photo[] }>(
    routes.albums.photos,
    {
      params: {
        id: album.id,
      },
      descriptor: "load photos",
    },
  );
  const { photos } = photosData ?? {};

  // == Imports
  useSubscription<{
    import: ICloudPhotosImport;
  }>("AlbumImportsChannel", {
    descriptor: "subscribe to album import updates",
    params: {
      album_id: album.id,
    },
    onData: () => {
      // TODO: Maintain an in-memory state of the import statuses.
      router.reload({ only: ["imports"] });
      mutate();
    },
  });

  // const [selectedPhoto, setSelectedPhoto] = useState<Photo | null>(null);

  // const photosFeatures = useMemo(() => {
  //   (photos ?? []).map<Feature<Point>>(({ location }) => ({
  //     type: "Feature",
  //     geometry: location,
  //     properties: {},
  //   }));
  // }, [photos]);

  return (
    <Flex
      pos="relative"
      style={{ flexGrow: 1, flexDirection: "column", alignItems: "stretch" }}
    >
      <Map
        initialViewState={{
          zoom: 12,
          latitude: 43.64609803809037,
          longitude: -79.38129195441373,
        }}
        style={{ flexGrow: 1 }}
      >
        {/* {selectedPhoto &&
          resolve(() => {
            const { location, image } = selectedPhoto;
            const [longitude, latitude] = location.coordinates as [
              number,
              number,
            ];
            return (
              <Popup
                {...{ latitude, longitude }}
                anchor="bottom"
                onClose={() => {
                  setSelectedPhoto(null);
                }}
              >
                <Image srcSet={image.srcSet} alt="" w="100%" />
              </Popup>
            );
          })} */}
        {photos?.map(photo => {
          const { location, image } = photo;
          const [longitude, latitude] = location.coordinates as [
            number,
            number,
          ];
          return (
            <Popup
              key={photo.id}
              className={classes.popup}
              {...{ latitude, longitude }}
              closeButton={false}
              anchor="bottom"
              // onClick={() => {
              //   setSelectedPhoto(photo);
              // }}
            >
              <Image srcSet={image.srcSet} alt="" w={140} h={140} />
            </Popup>
          );
        })}
        {/* <Source
          id="photos"
          type="geojson"
          data={{ type: "FeatureCollection", features: photosFeatures }}
        >
          <Layer
            id="photos"
            type="circle"
            paint={{
              "circle-radius": 4,
              "circle-color": "#cf4674",
            }}
          />
        </Source> */}
      </Map>
      <LoadingOverlay
        visible={!photos}
        loaderProps={{ type: "bars", color: "accent.4", size: "md" }}
      />
      {!isEmpty(imports) && (
        <Stack
          gap={8}
          pos="absolute"
          left="var(--mantine-spacing-xs)"
          top="var(--mantine-spacing-xs)"
          w={320}
        >
          {imports.map(photosImport => {
            const { createdAt, completedDownloadCount, downloadCount } =
              photosImport;
            const progress =
              downloadCount !== null
                ? (completedDownloadCount / downloadCount) * 100
                : 100;
            return (
              <Card key={photosImport.id} p="xs">
                <Stack gap={4}>
                  <Time format={DateTime.DATE_MED} fw={700}>
                    {createdAt}
                  </Time>
                  <Progress
                    value={progress}
                    animated={progress < 100 || downloadCount === null}
                    color="accent.4"
                    size="xs"
                  />
                  <Text c="dimmed" size="xs">
                    {downloadCount !== null ? (
                      <>
                        {completedDownloadCount} of {downloadCount} photos
                        imported
                      </>
                    ) : (
                      <>Indexing photos...</>
                    )}
                  </Text>
                </Stack>
              </Card>
            );
          })}
        </Stack>
      )}
    </Flex>
  );
};

AlbumPage.layout = buildLayout<AlbumPageProps>((page, { album }) => (
  <>
    <AppLayout title={album.title} padding={0}>
      {page}
    </AppLayout>
  </>
));

export default AlbumPage;
