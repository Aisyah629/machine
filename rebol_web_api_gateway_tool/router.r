REBOL [
    Title: "REBOL Router Module"
    Purpose: "Handles URL mapping and request dispatching for the API gateway."
]

; Router Object
router: make object! [
    routes: make block! []

    add-route: func [
        method [string!]
        path [string!]
        handler [function!]
    ] [
        insert tail routes reduce [method path handler]
    ]

    dispatch: func [
        request [block!]
        /local matched handler
    ] [
        foreach [method path handler] routes [
            if all [method = request/method path = request/path] [
                return do handler request
            ]
        ]
        print "Route not found: 404"
        return none
    ]
]

; Export router for use in main.r
ctx/router: router
