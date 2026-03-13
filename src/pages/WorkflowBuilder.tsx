import { useParams } from 'react-router-dom';

const WorkflowBuilder = () => {
  const { id } = useParams();

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-white">
        Workflow Builder
      </h1>
      <p className="text-gray-400 mt-4">Project: {id}</p>
      <p className="text-gray-500 mt-8">Workflow builder component coming soon</p>
    </div>
  );
};

export default WorkflowBuilder;
