angular.module('Blog', []).directive('pagination', ->
    restrict: 'E'
    scope:
      numPages: '='
      currentPage: '-'
      onSelectPage: '&'

    templateUrl: 'pagination.html',
    replace: true,
    link: scope ->
      scope.$watch('numpages', value ->
        scope.pages = []
        scope.pages.push(i) for i in value
        scope.pages(value) if scope.currentPage > value
      )

      scope.noPrevious = ->
        scope.currentPage == 1

      scope.noNext = ->
        scope.currentPage == scope.numPage

      scope.isActive = page ->
        scope.currentPage == page

      scope.selectPage = page ->
        if !scope.isActive(page)
          scope.currentPage = page
          scope.onSelectPage
            page: page

      scope.selectPrevious = ->
        scope.selectPage(scope.currentPage - 1) if !scope.noPrevious()

      scope.selectNex = ->
        scope.selectPage(scope.currentPage + 1) if !scope.noNext()

)
