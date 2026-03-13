import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { ArrowLeft, Download, Upload as UploadIcon } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { ProjectImage } from '@/types';

const DatasetView = () => {
  const { id } = useParams<{ id: string }>();
  const [images, setImages] = useState<ProjectImage[]>([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState<'all' | 'annotated' | 'unlabeled'>('all');
  const [search, setSearch] = useState('');
  const [exporting, setExporting] = useState(false);

  useEffect(() => {
    if (id) loadImages();
  }, [id]);

  const loadImages = async () => {
    try {
      const { data, error } = await supabase
        .from('images')
        .select('*')
        .eq('projectId', id)
        .order('uploadedAt', { ascending: false });

      if (error) throw error;
      setImages(data || []);
    } catch (err) {
      console.error('Error loading images:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files || !id) return;

    const files = Array.from(e.target.files);
    setLoading(true);

    try {
      for (const file of files) {
        const filename = `${Date.now()}-${file.name}`;
        const { data, error } = await supabase.storage
          .from('project-images')
          .upload(`${id}/${filename}`, file);

        if (error) throw error;

        await supabase.from('images').insert({
          projectId: id,
          filename: file.name,
          storageUrl: data.path,
          split: 'train',
          annotated: false,
        });
      }

      await loadImages();
    } catch (err) {
      console.error('Error uploading images:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleExport = async () => {
    setExporting(true);
    try {
      // Simple export as JSON for now
      const exportData = {
        projectId: id,
        exportDate: new Date().toISOString(),
        images: filteredImages.map(img => ({
          filename: img.filename,
          split: img.split,
          annotated: img.annotated,
        })),
      };

      const element = document.createElement('a');
      element.setAttribute(
        'href',
        'data:text/json;charset=utf-8,' + encodeURIComponent(JSON.stringify(exportData, null, 2))
      );
      element.setAttribute('download', `dataset-${id}-export.json`);
      element.style.display = 'none';
      document.body.appendChild(element);
      element.click();
      document.body.removeChild(element);
    } catch (err) {
      console.error('Error exporting:', err);
    } finally {
      setExporting(false);
    }
  };

  const filteredImages = images.filter(img => {
    const matchesFilter =
      filter === 'all' || (filter === 'annotated' && img.annotated) || (filter === 'unlabeled' && !img.annotated);
    const matchesSearch = img.filename.toLowerCase().includes(search.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  if (loading && images.length === 0) {
    return <div className="flex items-center justify-center h-full text-gray-400">Loading...</div>;
  }

  return (
    <div className="p-8">
      <Link to={`/project/${id}`} className="flex items-center gap-2 text-blue-400 hover:text-blue-300 mb-6">
        <ArrowLeft className="w-4 h-4" />
        Back to Project
      </Link>

      <div className="flex items-center justify-between mb-8">
        <h1 className="text-3xl font-bold text-white">Dataset</h1>
        <div className="flex gap-2">
          <button
            onClick={handleExport}
            disabled={exporting || images.length === 0}
            className="flex items-center gap-2 px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg transition-colors disabled:opacity-50"
          >
            <Download className="w-4 h-4" />
            Export
          </button>
          <label className="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors cursor-pointer">
            <UploadIcon className="w-4 h-4" />
            Upload
            <input
              type="file"
              multiple
              accept="image/*"
              onChange={handleUpload}
              className="hidden"
            />
          </label>
        </div>
      </div>

      <div className="mb-6 flex gap-4">
        <input
          type="text"
          placeholder="Search by filename..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="flex-1 px-4 py-2 bg-gray-800 border border-gray-700 text-white rounded-lg focus:outline-none focus:border-blue-500"
        />
        <select
          value={filter}
          onChange={(e) => setFilter(e.target.value as any)}
          className="px-4 py-2 bg-gray-800 border border-gray-700 text-white rounded-lg focus:outline-none focus:border-blue-500"
        >
          <option value="all">All Images</option>
          <option value="annotated">Annotated</option>
          <option value="unlabeled">Unlabeled</option>
        </select>
      </div>

      {filteredImages.length === 0 ? (
        <div className="text-center py-16">
          <p className="text-gray-400">No images found</p>
        </div>
      ) : (
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {filteredImages.map((img) => (
            <Link
              key={img.id}
              to={`/project/${id}/annotate/${img.id}`}
              className="group relative aspect-square bg-gray-800 rounded-lg overflow-hidden hover:border-blue-500 border border-gray-700 transition-colors cursor-pointer"
            >
              <img
                src={`${supabase.storage.from('project-images').getPublicUrl(img.storageUrl).data.publicUrl}`}
                alt={img.filename}
                className="w-full h-full object-cover group-hover:scale-105 transition-transform"
              />
              <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-end">
                <div className="w-full p-2 bg-gray-900/80">
                  <p className="text-xs text-white truncate">{img.filename}</p>
                  <span className={`text-xs font-medium ${img.annotated ? 'text-green-400' : 'text-yellow-400'}`}>
                    {img.annotated ? 'Annotated' : 'Unlabeled'}
                  </span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
};

export default DatasetView;
