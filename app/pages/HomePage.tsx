import AppLayout from "~/components/AppLayout";
import Map from "~/components/Map";

export interface HomePageProps extends SharedPageProps {
  announcement: string | null;
}

const HomePage: PageComponent<HomePageProps> = ({ announcement }) => {
  // == Announcement
  useEffect(() => {
    if (announcement) {
      showNotification({ message: announcement });
    }
  }, [announcement]);

  return (
    <Box pos="relative" display="table" style={{ flexGrow: 1 }}>
      <Map
        initialViewState={{
          zoom: 12,
          latitude: 43.64609803809037,
          longitude: -79.38129195441373,
        }}
        display="table-cell"
      />
    </Box>
  );
};

HomePage.layout = buildLayout<HomePageProps>(page => (
  <AppLayout padding={0}>{page}</AppLayout>
));

export default HomePage;
