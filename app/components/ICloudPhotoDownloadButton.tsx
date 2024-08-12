import type { ICloudPhotoDownload } from "~/types";
import type { AnchorProps } from "@mantine/core";

export interface ICloudPhotoDownloadButtonProps extends AnchorProps {
  download: ICloudPhotoDownload;
}

const ICloudPhotoDownloadButton: FC<ICloudPhotoDownloadButtonProps> = ({
  download,
  ...otherProps
}) => {
  // == Downloading
  const { submit, processing } = useFetchForm({
    action: routes.icloudPhotoDownloads.download,
    params: {
      id: download.id,
    },
    method: "post",
    descriptor: "download image",
    onSuccess: () => {
      showNotice({
        message: "Image downloaded successfully.",
      });
    },
  });

  return (
    <Anchor
      component="button"
      disabled={processing}
      onClick={() => {
        submit();
      }}
      {...otherProps}
    >
      {processing ? "downloading..." : "download"}
    </Anchor>
  );
};

export default ICloudPhotoDownloadButton;
