/*
  # Create workflows table

  1. New Tables
    - `workflows`
      - `id` (uuid, primary key)
      - `projectId` (uuid, foreign key)
      - `name` (text)
      - `nodes` (jsonb array)
      - `edges` (jsonb array)
      - `updatedAt` (timestamptz)

  2. Security
    - Enable RLS on `workflows` table
*/

CREATE TABLE IF NOT EXISTS workflows (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  projectId uuid NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  name text NOT NULL DEFAULT 'Untitled Workflow',
  nodes jsonb DEFAULT '[]'::jsonb,
  edges jsonb DEFAULT '[]'::jsonb,
  updatedAt timestamptz DEFAULT now()
);

ALTER TABLE workflows ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Workflows are viewable by everyone"
  ON workflows
  FOR SELECT
  USING (true);

CREATE POLICY "Users can insert workflows"
  ON workflows
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update workflows"
  ON workflows
  FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Users can delete workflows"
  ON workflows
  FOR DELETE
  USING (true);

CREATE INDEX idx_workflows_projectId ON workflows(projectId);
