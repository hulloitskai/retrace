import { default as _Map } from "react-map-gl";
import type { MapRef } from "react-map-gl";
import type { MapProps as _MapProps } from "react-map-gl";

import "mapbox-gl/dist/mapbox-gl.css";

export interface MapProps
  extends Omit<_MapProps, "mapboxAccessToken" | "projection" | "terrain">,
    Omit<BoxProps, "style"> {}

const Map = forwardRef<MapRef, MapProps>(
  (
    {
      mapStyle = "mapbox://styles/mapbox-map-design/cksjc2nsq1bg117pnekb655h1",
      children,
      ...otherProps
    },
    ref,
  ) => {
    const mapboxAccessToken = useMemo(() => getMeta("mapbox-access-token"), []);
    return (
      <Box
        component={_Map}
        {...{ ref, mapboxAccessToken, mapStyle }}
        attributionControl={false}
        {...otherProps}
      >
        {children}
      </Box>
    );
  },
);

export default Map;
