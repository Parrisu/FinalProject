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
      :cityName IS NULL
      OR f.node.city LIKE %:cityName%
    )
    AND (
      :stateAbbr IS NULL
      OR f.node.stateAbbreviation LIKE %:stateAbbr%
    )
    AND (
      :stack IS NULL
      OR EXISTS (
        SELECT
          t
        FROM
          Technology t
        WHERE
          t MEMBER OF f.node.stack
          AND t IN :stack
      )
    )
    AND f.enabled = true
    AND f.cancelled = false
  )
  AND (
    f.node.openToPublic = true
    OR (
      :username IS NULL
      OR :username IN (
        SELECT
          nm.user.username
        FROM
          Node node
          JOIN node.nodeMembers nm
        WHERE
          node = f.node
      )
    )
  )
