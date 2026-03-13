/*
  # Create label_classes table

  1. New Tables
    - `label_classes`
      - `id` (uuid, primary key)
      - `projectId` (uuid, foreign key)
      - `name` (text)
      - `color` (text, hex color)
      - `createdAt` (timestamptz)

  2. Security
    - Enable RLS on `label_classes` table
*/

CREATE TABLE IF NOT EXISTS label_classes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  projectId uuid NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  name text NOT NULL,
  color text NOT NULL,
  createdAt timestamptz DEFAULT now()
);

ALTER TABLE label_classes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Classes are viewable by everyone"
  ON label_classes
  FOR SELECT
  USING (true);

CREATE POLICY "Users can insert classes"
  ON label_classes
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update classes"
  ON label_classes
  FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Users can delete classes"
  ON label_classes
  FOR DELETE
  USING (true);

CREATE INDEX idx_label_classes_projectId ON label_classes(projectId);
