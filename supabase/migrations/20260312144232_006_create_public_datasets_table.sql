/*
  # Create public_datasets table

  1. New Tables
    - `public_datasets`
      - `id` (uuid, primary key)
      - `name` (text)
      - `description` (text)
      - `taskType` (enum)
      - `imageCount` (integer)
      - `classes` (jsonb array)
      - `tags` (jsonb array)
      - `previewImages` (jsonb array)
      - `likeCount` (integer)
      - `forkCount` (integer)
      - `authorId` (text)
      - `authorName` (text)
      - `isPublic` (boolean)
      - `createdAt` (timestamptz)

  2. Security
    - Enable RLS on `public_datasets` table
*/

CREATE TABLE IF NOT EXISTS public_datasets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  taskType text NOT NULL CHECK (taskType IN ('detection', 'classification', 'segmentation')),
  imageCount integer DEFAULT 0,
  classes jsonb DEFAULT '[]'::jsonb,
  tags jsonb DEFAULT '[]'::jsonb,
  previewImages jsonb DEFAULT '[]'::jsonb,
  likeCount integer DEFAULT 0,
  forkCount integer DEFAULT 0,
  authorId text,
  authorName text,
  isPublic boolean DEFAULT true,
  createdAt timestamptz DEFAULT now()
);

ALTER TABLE public_datasets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public datasets are viewable by everyone"
  ON public_datasets
  FOR SELECT
  USING (isPublic = true);

CREATE POLICY "Users can insert public datasets"
  ON public_datasets
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update public datasets"
  ON public_datasets
  FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Users can delete public datasets"
  ON public_datasets
  FOR DELETE
  USING (true);

CREATE INDEX idx_public_datasets_taskType ON public_datasets(taskType);
CREATE INDEX idx_public_datasets_isPublic ON public_datasets(isPublic);
CREATE INDEX idx_public_datasets_createdAt ON public_datasets(createdAt DESC);
