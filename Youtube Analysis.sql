USE Youtube;
select * from channel_engagement;-- engagement_id,channel_id,likes_per_video,comments_per_video,shares_per_video
select * from channel_revenue; -- revenue_id, channel_id, monthly_revenue, yearly_revenue
select * from channel_videos; -- video_id,channel_id,video_title,upload_date,views,likes,comments
select * from youtube_channels; -- channel_id, channel_name, category, subscribers,avg_views,nox_score

-- 1 Get the top 5 most subscribed YouTube channels ?
SELECT 
      channel_name AS Top_5_Youtube_Channels, 
      MAX(subscribers) AS Subscribers
FROM youtube_channels 
GROUP BY channel_name 
ORDER BY Subscribers DESC 
LIMIT 5;

-- 2 Find the total yearly revenue of all channels ?
Select 
      channel_name AS Channel_Name, 
      SUM(yearly_revenue) as Yearly_Revenue 
FROM youtube_channels
JOIN channel_revenue ON youtube_channels.channel_id = channel_revenue.channel_id 
GROUP BY Channel_Name 
ORDER BY Yearly_Revenue DESC;

-- 3 Find the video uploaded by 'MrBeast' ?
SELECT
      yc.channel_name as Channel_Name, 
      cv.video_title 
FROM youtube_channels yc
LEFT JOIN channel_videos cv ON yc.channel_id = cv.channel_id 
WHERE yc.channel_name = "MrBeast";

-- 4 Get the average engagement (likes & comments) per video for each channel ?
SELECT 
      channel_name AS Channel_Name, 
      Round(AVG(likes_per_video),0) AS Avg_Likes, 
      Round(AVG(comments_per_video),0) AS Avg_Comments 
FROM youtube_channels
LEFT JOIN channel_engagement ON youtube_channels.channel_id = channel_engagement.channel_id
GROUP BY channel_name 
Order by Avg_Likes;

-- 5 List channels that have a NOX score higher than 10 ?
SELECT
      channel_name AS Channel_Name, 
      nox_score AS Nox_Score 
FROM youtube_channels
WHERE nox_score > 10 
ORDER BY Nox_Score DESC;

-- 6 Find the most commented video ?
SELECT 
      CV.video_title AS Video_Title, 
      SUM(CE.comments_per_video) AS High_Comments 
FROM channel_videos CV
LEFT JOIN channel_engagement CE ON CV.channel_id = CE.channel_id 
GROUP BY Video_Title
ORDER BY High_Comments DESC 
LIMIT 1;

-- 7 Count the total number of channels in each category ?
SELECT 
	  category as Category, 
      COUNT(channel_name) AS Total_Channels 
FROM youtube_channels
GROUP BY Category 
Order by Total_Channels DESC; 

-- 8 Search for channel names that start with "M" and end with "t" (using Like function) ?
SELECT 
	  channel_name AS Channel_Name 
FROM youtube_channels
WHERE channel_name LIKE "M%" AND channel_name LIKE "%t";

-- 9 Find videos uploaded between '2024-03-01' AND '2024-08-01' ?
SELECT 
      video_title AS Video_Title 
FROM channel_videos 
WHERE upload_date BETWEEN '2024-03-01' AND '2024-08-01';

-- 10 Find the top 3 most liked videos on YouTube ?
SELECT 
      video_title AS Top_3_Videos, 
	  MAX(likes) AS Total_Likes 
FROM channel_videos
GROUP BY Top_3_Videos 
ORDER BY Total_Likes DESC 
LIMIT 3;