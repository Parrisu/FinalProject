SELECT
  DISTINCT f
FROM
  Function f
WHERE
  (
    (
      (:searchQuery IS NULL)
      OR f.name LIKE %:searchQuery%
    )
    AND (
      :enabled IS NULL
      OR :enabled = f.enabled
    )
    AND (
      :cancelled IS NULL
      OR :cancelled = f.cancelled
    )
  )
  AND (
    f.node.openToPublic = true
    OR (
      :userId IS NULL
      OR :userId IN (
        SELECT
          nm.user.id
        FROM
          node.nodeMembers nm
      )
    )
  )
