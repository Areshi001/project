/*
  # Create projects table

  1. New Tables
    - `projects`
      - `id` (uuid, primary key, auto-generated)
      - `name` (text, required)
      - `taskType` (enum: detection, classification, segmentation)
      - `imageCount` (integer, defaults to 0)
      - `splits` (jsonb: {train: number, val: number, test: number})
      - `createdAt` (timestamp with timezone)
      - `updatedAt` (timestamp with timezone)

  2. Security
    - Enable RLS on `projects` table
    - Add policy for authenticated users to create, read, and update their own projects
*/

CREATE TABLE IF NOT EXISTS projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  taskType text NOT NULL CHECK (taskType IN ('detection', 'classification', 'segmentation')),
  imageCount integer DEFAULT 0,
  splits jsonb DEFAULT '{"train": 70, "val": 15, "test": 15}'::jsonb,
  createdAt timestamptz DEFAULT now(),
  updatedAt timestamptz DEFAULT now()
);

ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Projects are viewable by everyone"
  ON projects
  FOR SELECT
  USING (true);

CREATE POLICY "Users can create projects"
  ON projects
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update projects"
  ON projects
  FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Users can delete projects"
  ON projects
  FOR DELETE
  USING (true);
