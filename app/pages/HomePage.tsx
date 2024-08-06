import { Text } from "@mantine/core";

import AppLayout from "~/components/AppLayout";

export interface HomePageProps extends SharedPageProps {
  announcement: string | null;
}

const HomePage: PageComponent<HomePageProps> = ({ announcement }) => {
  useEffect(() => {
    if (announcement) {
      showNotice({ message: announcement });
    }
  }, [announcement]);
  return <Text>&apos;sup</Text>;
};

HomePage.layout = buildLayout<HomePageProps>(page => (
  <>
    <AppLayout withContainer withGutter>
      <Head>
        <link
          rel="alternate"
          type="application/atom+xml"
          href="/feed.atom"
          title="Atom Feed"
        />
      </Head>
      {page}
    </AppLayout>
  </>
));

export default HomePage;
