import { useParams } from 'react-router-dom';

const DatasetDetail = () => {
  const { datasetId } = useParams();

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-white">
        Dataset Detail
      </h1>
      <p className="text-gray-400 mt-4">Dataset: {datasetId}</p>
      <p className="text-gray-500 mt-8">Dataset detail component coming soon</p>
    </div>
  );
};

export default DatasetDetail;
