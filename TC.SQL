/* 
    LOADING YIMIAN SOCIAL POSTS

    * DESCRIPTION *
    Query to extract the latest posts from the Yimian social media tables.

    * ARGUMENTS *
    - {{VERTICAL}} 
        Should be replaced with one of the following vertical names:
         - BEAUTY
         - FASHION
         - FD
         - FOOTWEAR
         - LI
        For example, YIMIAN.SOCIAL.YIMIAN_INSTAGRAM_FD for the F&D social posts.

    * DETAILS *
    Some posts can have multiple entries in the table, therefore we need to remove duplicates,
    but ensure we keep the right post. The right post in this instance is the one with the most
    buzz (likes + comments). This is because it is assumed the entry with the most buzz will be
    the most recent and up-to-date scrape of that post. 
    
    To do this a CTE (get_recent_scrape) is created that groups duplicate entries together and 
    orders them by buzz. The ROW_NUMBER function assigns an ascending number to each posts'
    entry, with '1' being the post with the highest buzz.

    A second query then takes this CTE and filters to only include entries with a '1' to load
    the most recent post scrapes.

    * VERSION *
    1.0
    Last modified 2024/01/09 by Joseph Earle 
    
*/

WITH get_recent_scrape AS (
  SELECT 
      y.USER_ID
      ,y.USER_NAME
      ,y.REGION
      ,y.SEGMENT
      ,y.CONTENT
      ,y.POST_URL
      ,y.POST_DATE
      ,y.LIKE_COUNT + y.COMMENT_COUNT AS BUZZ
      ,ROW_NUMBER() OVER(PARTITION BY y.USER_ID, y.POST_ID ORDER BY y.LIKE_COUNT DESC) as ROW_NUM
  FROM 
      YIMIAN.SOCIAL.YIMIAN_INSTAGRAM_{{VERTICAL}} AS y
)

SELECT 
    grs.USER_ID
    ,grs.USER_NAME
    ,grs.REGION
    ,grs.SEGMENT
    ,grs.CONTENT
    ,grs.POST_URL
    ,grs.POST_DATE
    ,grs.BUZZ
FROM get_recent_scrape AS grs
WHERE grs.ROW_NUM = 1
