#= require bookmarklet/requires/give_puppies

describe 'GivePuppies', ->
  describe 'CONTEXT: \'default puppies\'', ->
    beforeEach ->
      @give_puppies = new GivePuppies()

    it 'has a pups value set', ->
      expect(@give_puppies.pups.length).toEqual(10)

    it 'can find 3 horizontal', ->
      expect(@give_puppies.pups_for_orientation('hor').length).toEqual(3)

    it 'can find 3 vertical', ->
      expect(@give_puppies.pups_for_orientation('ver').length).toEqual(3)

    it 'can find 4 square', ->
      expect(@give_puppies.pups_for_orientation('squ').length).toEqual(4)

    describe '.orientation_for(image)', ->
      beforeEach ->
        loadFixtures('give_puppies.html')
        @pup_images = document.getElementsByTagName('img')

      it 'grabs all of the image tags on a page', ->
        expect(@pup_images.length).toEqual(3)

      it 'gets the orientation of image 1', ->
        console.log(@pup_images[0])

        expect(@give_puppies.orientation_for(@pup_images[0])).toEqual('hor')

      it 'gets the orientation of image 2', ->
        console.log(@pup_images[1])

        expect(@give_puppies.orientation_for(@pup_images[1])).toEqual('ver')

      it 'gets the orientation of image 3', ->
        console.log(@pup_images[2])

        expect(@give_puppies.orientation_for(@pup_images[2])).toEqual('squ')