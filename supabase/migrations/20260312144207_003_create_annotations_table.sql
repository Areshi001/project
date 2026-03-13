/*
  # Create annotations table

  1. New Tables
    - `annotations`
      - `id` (uuid, primary key)
      - `projectId` (uuid, foreign key)
      - `imageId` (uuid, foreign key)
      - `type` (enum: bbox, polygon)
      - `classId` (uuid)
      - `className` (text)
      - `color` (text, hex color)
      - `x`, `y`, `width`, `height` (for bbox)
      - `points` (jsonb array for polygon)
      - `createdAt` (timestamptz)

  2. Security
    - Enable RLS on `annotations` table
*/

CREATE TABLE IF NOT EXISTS annotations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  projectId uuid NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  imageId uuid NOT NULL REFERENCES images(id) ON DELETE CASCADE,
  type text NOT NULL CHECK (type IN ('bbox', 'polygon')),
  classId text NOT NULL,
  className text NOT NULL,
  color text NOT NULL,
  x numeric,
  y numeric,
  width numeric,
  height numeric,
  points jsonb,
  createdAt timestamptz DEFAULT now()
);

ALTER TABLE annotations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Annotations are viewable by everyone"
  ON annotations
  FOR SELECT
  USING (true);

CREATE POLICY "Users can insert annotations"
  ON annotations
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update annotations"
  ON annotations
  FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Users can delete annotations"
  ON annotations
  FOR DELETE
  USING (true);

CREATE INDEX idx_annotations_imageId ON annotations(imageId);
CREATE INDEX idx_annotations_projectId ON annotations(projectId);
