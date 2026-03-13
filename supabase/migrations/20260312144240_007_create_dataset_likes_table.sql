/*
  # Create dataset_likes table

  1. New Tables
    - `dataset_likes`
      - `id` (uuid, primary key)
      - `datasetId` (uuid, foreign key)
      - `userId` (text)
      - `likedAt` (timestamptz)

  2. Security
    - Enable RLS on `dataset_likes` table
*/

CREATE TABLE IF NOT EXISTS dataset_likes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  datasetId uuid NOT NULL REFERENCES public_datasets(id) ON DELETE CASCADE,
  userId text NOT NULL,
  likedAt timestamptz DEFAULT now(),
  UNIQUE(datasetId, userId)
);

ALTER TABLE dataset_likes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Likes are viewable by everyone"
  ON dataset_likes
  FOR SELECT
  USING (true);

CREATE POLICY "Users can insert likes"
  ON dataset_likes
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can delete their likes"
  ON dataset_likes
  FOR DELETE
  USING (true);

CREATE INDEX idx_dataset_likes_datasetId ON dataset_likes(datasetId);
CREATE INDEX idx_dataset_likes_userId ON dataset_likes(userId);
