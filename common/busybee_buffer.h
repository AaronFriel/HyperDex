// Copyright (c) 2026

#ifndef hyperdex_common_busybee_buffer_h_
#define hyperdex_common_busybee_buffer_h_

// STL
#include <memory>

// e
#include <e/buffer.h>

// HyperDex
#include "namespace.h"

BEGIN_HYPERDEX_NAMESPACE

inline std::auto_ptr<e::buffer>
busybee_auto_ptr(std::unique_ptr<e::buffer> msg)
{
    return std::auto_ptr<e::buffer>(msg.release());
}

inline std::unique_ptr<e::buffer>
busybee_unique_ptr(std::auto_ptr<e::buffer>* msg)
{
    return std::unique_ptr<e::buffer>(msg->release());
}

END_HYPERDEX_NAMESPACE

#endif // hyperdex_common_busybee_buffer_h_
