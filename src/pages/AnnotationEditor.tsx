import { useParams } from 'react-router-dom';

const AnnotationEditor = () => {
  const { id, imageId } = useParams();

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-white">
        Annotation Editor
      </h1>
      <p className="text-gray-400 mt-4">
        Project: {id} | Image: {imageId}
      </p>
      <p className="text-gray-500 mt-8">Annotation canvas component coming soon</p>
    </div>
  );
};

export default AnnotationEditor;
