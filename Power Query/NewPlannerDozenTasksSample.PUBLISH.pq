let
    // Helper function to generate a date string
    DateString = (year as number, month as number, day as number) as text =>
        DateTime.ToText(#datetime(year, month, day, 17, 0, 0), "yyyy-MM-ddTHH:mm:ssZ"),

    SamplePlannerData = {
        [
            id = "task-001",
            title = "Prepare project kickoff",
            assignedTo = {
                [
                    userId = "user-100",
                    displayName = "Alice Johnson",
                    email = "alice.johnson@contoso.com"
                ]
            },
            dueDate = DateString(2025, 5, 25),
            bucketId = "bucket-01"
        ],
        [
            id = "task-002",
            title = "Design wireframes",
            assignedTo = {
                [
                    userId = "user-101",
                    displayName = "Bob Smith",
                    email = "bob.smith@contoso.com"
                ],
                [
                    userId = "user-102",
                    displayName = "Carol Lee",
                    email = "carol.lee@contoso.com"
                ]
            },
            dueDate = DateString(2025, 5, 28),
            bucketId = "bucket-02"
        ],
        [
            id = "task-003",
            title = "Review requirements",
            assignedTo = {
                [
                    userId = "user-103",
                    displayName = "David Kim",
                    email = "david.kim@contoso.com"
                ]
            },
            dueDate = DateString(2025, 5, 30),
            bucketId = "bucket-01"
        ],
        [
            id = "task-004",
            title = "Develop backend API",
            assignedTo = {
                [
                    userId = "user-104",
                    displayName = "Emma White",
                    email = "emma.white@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 2),
            bucketId = "bucket-03"
        ],
        [
            id = "task-005",
            title = "Frontend integration",
            assignedTo = {
                [
                    userId = "user-105",
                    displayName = "George Brown",
                    email = "george.brown@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 5),
            bucketId = "bucket-02"
        ],
        [
            id = "task-006",
            title = "QA test plan",
            assignedTo = {
                [
                    userId = "user-106",
                    displayName = "Hannah Green",
                    email = "hannah.green@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 7),
            bucketId = "bucket-04"
        ],
        [
            id = "task-007",
            title = "Security review",
            assignedTo = {
                [
                    userId = "user-107",
                    displayName = "Ian Black",
                    email = "ian.black@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 4),
            bucketId = "bucket-03"
        ],
        [
            id = "task-008",
            title = "Performance testing",
            assignedTo = {
                [
                    userId = "user-108",
                    displayName = "Julia King",
                    email = "julia.king@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 10),
            bucketId = "bucket-04"
        ],
        [
            id = "task-009",
            title = "Documentation draft",
            assignedTo = {
                [
                    userId = "user-109",
                    displayName = "Kevin Scott",
                    email = "kevin.scott@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 8),
            bucketId = "bucket-05"
        ],
        [
            id = "task-010",
            title = "Stakeholder review",
            assignedTo = {
                [
                    userId = "user-110",
                    displayName = "Laura Adams",
                    email = "laura.adams@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 12),
            bucketId = "bucket-01"
        ],
        [
            id = "task-011",
            title = "Bug fixing sprint",
            assignedTo = {
                [
                    userId = "user-101",
                    displayName = "Bob Smith",
                    email = "bob.smith@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 14),
            bucketId = "bucket-03"
        ],
        [
            id = "task-012",
            title = "Final QA",
            assignedTo = {
                [
                    userId = "user-106",
                    displayName = "Hannah Green",
                    email = "hannah.green@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 16),
            bucketId = "bucket-04"
        ],
        [
            id = "task-013",
            title = "Release preparation",
            assignedTo = {
                [
                    userId = "user-110",
                    displayName = "Laura Adams",
                    email = "laura.adams@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 18),
            bucketId = "bucket-05"
        ],
        [
            id = "task-014",
            title = "Go-live",
            assignedTo = {
                [
                    userId = "user-100",
                    displayName = "Alice Johnson",
                    email = "alice.johnson@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 20),
            bucketId = "bucket-01"
        ],
        [
            id = "task-015",
            title = "Post-launch support",
            assignedTo = {
                [
                    userId = "user-103",
                    displayName = "David Kim",
                    email = "david.kim@contoso.com"
                ]
            },
            dueDate = DateString(2025, 6, 25),
            bucketId = "bucket-05"
        ]
    }
in
    SamplePlannerData