#= require bookmarklet/requires/puppy

describe 'Puppy', ->
  beforeEach ->
    @puppy = new Puppy(1, 'hor')

  it 'has an id', ->
    expect(@puppy.id).toEqual(1)

  it 'has an orientation', ->
    expect(@puppy.orientation).toEqual('hor')

  it 'generates a consistent url based on a given size', ->
    expect(@puppy.image_url('sm')).toEqual('http://givepuppi.es/puppies/sm/1.png')