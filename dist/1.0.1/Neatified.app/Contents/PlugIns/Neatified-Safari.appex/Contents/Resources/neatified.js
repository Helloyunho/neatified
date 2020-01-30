const profiles = [
  // NOTE: Disabled
  {
    events: [],
    attributes: [],
    useStyle: false,
    useObserver: false
  },
  // NOTE: (Recommendation) Balanced
  {
    events: ['copy', 'dragstart', 'contextmenu', 'selectstart'],
    attributes: ['oncontextmenu'],
    useStyle: true,
    useObserver: true
  },
  // NOTE: Strict
  {
    events: [
      'copy',
      'dragstart',
      'contextmenu',
      'selectstart',
      'selectionchange',
      'mouseup',
      'mousedown'
    ],
    attributes: ['oncontextmenu'],
    useStyle: true,
    useObserver: true
  }
]

document.addEventListener('DOMContentLoaded', function (event) {
  function gotLevel (safariEvent) {
    function neatified (profile) {
      async function neatify (options, elements) {
        elements = elements || Array.from(document.querySelectorAll('*'))

        for (let i = 0; i < elements.length; i++) {
          const element = elements[i]

          if (typeof element === 'object' && element !== null) {
            for (let k = 0; k < options.events.length; k++) {
              const eventName = options.events[k]

              element.addEventListener(
                eventName,
                function (event) {
                  event.stopPropagation()
                },
                true
              )
            }
            for (let j = 0; j < options.attributes.length; j++) {
              const attrName = options.attributes[j]

              if (
                element.nodeType !=
                3 /* If Node is not [object Text] (Text node) */
              ) {
                element.removeAttribute(attrName)
              }
            }
          }
        }
      }
      function reformStyle () {
        const styleCtx = `
                                    *, *::after, *::before {
                                      -webkit-user-select: auto !important;
                                      -webkit-user-drag: auto !important;
                                      -webkit-app-region: auto !important;
                                    }
                                  `
        const style = document.createElement('style')

        style.innerHTML = styleCtx

        document.querySelector('head').appendChild(style)
      }
      function observeElements () {
        const observer = new MutationObserver(async function (mutationList) {
          const nodeAdded = []

          for (let k = 0; k < mutationList.length; k++) {
            await nodeAdded.push(...mutationList[k].addedNodes)
          }

          neatify(profile, Array.from(nodeAdded))
        })
      }

      neatify(profile)

      if (profile.useStyle) reformStyle()
      if (profile.useObserver) observeElements()
    }
    if (safariEvent.name === 'gotLevel') {
      const preferences = safariEvent.message
      neatified(profiles[preferences.level - 1])
    }
  }
  safari.self.addEventListener('message', gotLevel, false)
  safari.extension.dispatchMessage('getLevel')
})
