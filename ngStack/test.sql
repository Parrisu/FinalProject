SELECT
    DISTINCT node
FROM
    Node node
WHERE
    node.enabled = true
    AND (
        :searchQuery IS NULL
        OR node.name LIKE %:searchQuery%
        OR EXISTS (
            SELECT
                t
            FROM
                Technology t
            WHERE
                t MEMBER OF node.stack
                AND t.name LIKE %:searchQuery%
        )
    )
    AND (
        :city IS NULL
        OR node.city LIKE % :city %
    )
    AND (
        :stateAbbr IS NULL
        OR node.stateAbbreviation LIKE %:stateAbbr%
    )
    AND (
        :stack IS NULL
        OR EXISTS (
            SELECT
                t
            FROM
                Technology t
            WHERE
                t MEMBER OF node.stack
                AND t IN :stack
        )
    )
